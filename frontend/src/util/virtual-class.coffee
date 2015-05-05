VirtualClass = (classes...)->
  classes.reduceRight (Parent, Child)->
    class ChildProjection extends Parent
      constructor: ->
        # Temporary replace Child.__super__ and call original `constructor`
        child_super = Child.__super__
        Child.__super__ = ChildProjection.__super__
        Child.apply @, arguments
        Child.__super__ = child_super

        # If Child.__super__ not exists, manually call parent `constructor`
        unless child_super?
          super

    # Mixin prototype properties, except `constructor`
    for own key  of Child::
      if Child::[key] isnt Child
        ChildProjection::[key] = Child::[key]

    # Mixin static properties, except `__super__`
    for own key  of Child
      if Child[key] isnt Object.getPrototypeOf(Child::)
        ChildProjection[key] = Child[key]

    ChildProjection

module.exports = VirtualClass