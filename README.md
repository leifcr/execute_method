# Execute Method 

*execute_method.coffee* is a coffeescript that makes it possible to execute a method or get a property from a given string

It attaches ExecuteMethod to the window to make it easier to use across libraries. It does check for already existance in case you include it multiple times.

## Usage

```coffeescript
Animal = {
  type_of_animals: "cows"
  candostuff: ->
    "yes"
  cows:
   first:
    name: "george"
    dostuff: -> "eat"
   second:
    name: "peter"
    dostuff: ->
      {eat: "grass", sleep:"standing"}
   third:
     name: "ole"
     dostuff: (stuff_todo, should_i_do_it) ->
       return null unless should_i_do_it 
       stuff_todo

ExecuteMethod.executeMethodByFunctionName("type_of_animals", AnimalTest)             
# returns "cows"
ExecuteMethod.executeMethodByFunctionName("candostuff()", AnimalTest)                
# returns "yes"
ExecuteMethod.executeMethodByFunctionName("cows.first.name", AnimalTest)             
# returns  "george"
ExecuteMethod.executeMethodByFunctionName("cows.first.dostuff()", AnimalTest)        
# returns  "eat"
ExecuteMethod.executeMethodByFunctionName("cows.second.name", AnimalTest)            
# returns "peter"
ual(ExecuteMethod.executeMethodByFunctionName("cows.second.dostuff()", AnimalTest)   
# returns  {eat: "grass", sleep:"standing"}
ExecuteMethod.executeMethodByFunctionName("cows.second.dostuff().eat", AnimalTest)   
# returns  "grass"
ExecuteMethod.executeMethodByFunctionName("cows.second.dostuff().sleep", AnimalTest) 
# returns "standing"
ExecuteMethod.executeMethodByFunctionName("cows.third.name", AnimalTest)             
# returns "ole")
ExecuteMethod.executeMethodByFunctionName("cows.third.dostuff(\"run\", false)", AnimalTest) 
# returns null
ExecuteMethod.executeMethodByFunctionName("cows.third.dostuff(\"run\", true)", AnimalTest)  
# returns "run"

```

## Requirements

CoffeeScript (1.4 or newer)

## Browser Compatibility

* Chrome

* Firefox

* Internet Explorer 8+

If you have a mac, please test Safari and get back to me if things aren't working.

## License

This work is under the FreeBSD License.

As this is *free* for use in other products, please consider sending me a gadget if you charge your customers, or a license for the software/service you use it in. 