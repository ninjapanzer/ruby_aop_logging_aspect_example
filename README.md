# ruby_aop_logging_aspect_example
A toy to show how we can create annotation based aspects in ruby to provide a logging hook

The purpose here is to give an example of how some simple ruby lifecycle hooks can be use to create annotation based AOP interfaces.

Aspect Oriented Programming https://en.wikipedia.org/wiki/Aspect-oriented_programming

Is a common practice in OOP as a way to modularize cross cutting concerns like logging.

Consider how sorbet `sig` annotations work. This AOP pattern allows the `sig { void }` to inject and enforce a return type on the class it annotates.

In this example we want to separate logging around an instance method for purposes of creating an unindexed set of logs in our logging platform.

We do not want to have to test that this specific log has been created when the method is invocked so we provide it a logging aspect that we can test separately.

Inspecting the logs in output.log you will see that we have some state mapped to the loggs not produced by the Operation class.

## Setup and Usage
This project uses ASDF https://asdf-vm.com/

```sh
make init
```

### See the example
```sh
make run
```
or
```sh
ruby main.rb
```
