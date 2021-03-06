Q = require 'q'
db = require '../src/api/database.coffee'

db.Comment.sequelize.sync
Q.spawn ->
  yield db.Post.sequelize.sync force: true
  post1 = yield db.Post.create
    slug: 'mono-frustrations'
    title: 'Mono frustrations'
    author: 'Ayende Rahien'
    tags: ['development']
    body: """I’m porting Voron to Mono (currently testing on Ubuntu). I’m using Mono 3.2.8, FWIW, and working in MonoDevelop.

          So far, I have run into the following tangles that are annoying.  Attempting to write to memory that is write protected results in null reference exception, instead of access violation exception. I suspect that this is done because NRE is generated on any SIGSEGV, but that led me to a very different path of discovery.

          Also, consider the following code:

          ```
          using System.IO;
          using System.IO.Compression;

          namespace HelloWorld
          {
              class MainClass
              {
                  public static void Main (string[] args)
                  {
                      new ZipArchive (new MemoryStream ());
                  }
              }
          }
          ```

          This results in the following error:

          Unhandled Exception:
              System.NotImplementedException: The requested feature is not implemented.
                  at HelloWorld.MainClass.Main (System.String[] args) [0x00006] in /home/ayende/HelloWorld/HelloWorld/Program.cs:11
                  [ERROR] FATAL UNHANDLED EXCEPTION: System.NotImplementedException: The requested feature is not implemented.
                  at HelloWorld.MainClass.Main (System.String[] args) [0x00006] in /home/ayende/HelloWorld/HelloWorld/Program.cs:11

          This is annoying in that it isn’t implemented, but worse from my point of view is that I don’t see any ZipArchive in the stack trace. That made me think that it was my code that was throwing this."""

  comment1 = yield db.Comment
    .create
      author: 'Jan Deelstra'
      body: 'Brainfart.'
      succes: ->

  comment2 = yield db.Comment
    .create
      author: 'Ayende Rahien'
      body: 'Made me think that it was my code that was throwing this.'

  #comment1.addPost(post1)
  post1.setComments([comment1, comment2])

  db.Post
    .create
      slug: 'complex-nested-structures-in-ravendb'
      title: 'Complex nested structures in RavenDB'
      author: 'Ayende Rahien'
      tags: ['raven']
      body: """This started out as a question in the mailing list. Consider the following (highly simplified) model:

            ```
               public class Building
               {
                   public string Name { get; set; }
                   public List<Floor> Floors { get; set; }
               }

               public class Floor
               {
                   public int Number { get; set; }
                   public List<Apartment> Apartments { get; set; }
               }

               public class Apartment
               {
                   public string ApartmentNumber { get; set; }
                   public int SquareFeet { get; set; }
               }
            ```
            And here you can see an actual document:
            ```
            {
                "Name": "Corex's Building - Herzliya",
                "Floors": [
                    {
                        "Number": 1,
                        "Apartments": [
                            {
                                "ApartmentNumber": 102,
                                "SquareFeet": 260
                            },
                            {
                                "ApartmentNumber": 104,
                                "SquareFeet": 260
                            },
                            {
                                "ApartmentNumber": 107,
                                "SquareFeet": 460
                            }
                        ]
                    },
                    {
                        "Number": 2,
                        "Apartments": [
                            {
                                "ApartmentNumber": 201,
                                "SquareFeet": 260
                            },
                            {
                                "ApartmentNumber": 203,
                                "SquareFeet": 660
                            }
                        ]
                    }
                ]
            }
            Usually the user is working with the Building document. But every now an then, they need to show just a specific apartment.

            Normally, I would tell them that they can just load the relevant document and extract the inner information on the client, that is very cheap to do. And that is still the recommendation. But I thought that I would use this opportunity to show off some features that don’t get their due exposure.

            We then define the following index:

            image

            Note that we can use the Query() method to fetch the query specific parameter from the user. Then we just search the data for the relevant item.

            From the client code, this will look like:

            var q = session.Query<Building>()
                .Where(b =>/* some query for building */)
                .TransformWith<SingleApartment, Apartment>()
                .AddTransformerParameter("apartmentNumber", 201)
                .ToList();

            var apartment = session.Load<SingleApartment, Apartment>("building/123",
                    configuration => configuration.AddTransformerParameter("apartmentNumber", 102));
            And that is all there is to it."""
