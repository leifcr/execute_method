# Execute Method

*execute_method.coffee* is a coffeescript that makes it possible to execute a method or get a property from a given string

It attaches ExecuteMethod to the window to make it easier to use across libraries. It does check for already existance in case you include it multiple times.

## Usage

```javascript
var Animal;

Animal = {
  type_of_animals: "cows",
  candostuff: function() {
    return "yes";
  },
  cows: {
    first: {
      name: "george",
      dostuff: function() {
        return "eat";
      }
    },
    second: {
      name: "peter",
      dostuff: function() {
        return {
          eat: "grass",
          sleep: "standing"
        };
      }
    },
    third: {
      name: "ole",
      dostuff: function(stuff_todo, should_i_do_it) {
        if (!should_i_do_it) {
          return null;
        }
        return stuff_todo;
      }
    }
  }
};

ExecuteMethod.executeMethodByFunctionName("type_of_animals", Animal)
// -> "cows"
ExecuteMethod.executeMethodByFunctionName("candostuff()", Animal)
// -> "yes"
ExecuteMethod.executeMethodByFunctionName("cows.first.name", Animal)
// ->  "george"
ExecuteMethod.executeMethodByFunctionName("cows.first.dostuff()", Animal)
// ->  "eat"
ExecuteMethod.executeMethodByFunctionName("cows.second.name", Animal)
// -> "peter"
ExecuteMethod.executeMethodByFunctionName("cows.second.dostuff()", Animal)
// -> {eat: "grass", sleep:"standing"}
ExecuteMethod.executeMethodByFunctionName("cows.second.dostuff().eat", Animal)
// -> "grass"
ExecuteMethod.executeMethodByFunctionName("cows.second.dostuff().sleep", Animal)
// -> "standing"
ExecuteMethod.executeMethodByFunctionName("cows.third.name", Animal)
// -> "ole")
ExecuteMethod.executeMethodByFunctionName("cows.third.dostuff(\"run\", false)", Animal)
// -> null
ExecuteMethod.executeMethodByFunctionName("cows.third.dostuff(\"run\", true)", Animal)
// -> "run"

```

## Browser Compatibility

* Chrome

* Firefox

* Internet Explorer 8+

* Safari

## Development Requirements

CoffeeScript (1.4 or newer)

## License

This work is under the BSD-2-Clause-FreeBSD License.

As this is *free* for use in other products, please consider sending me a gadget if you charge your customers, or a license for the software/service you use it in.
