package airportrobot

import "fmt"

type Greeter interface {
	LanguageName() string
	Greet(name string) string
	hello(name string) string
}

func SayHello(name string, greeter Greeter) string {
	return greeter.Greet(name)
}

func greet(name string, greeter Greeter) string {
	return fmt.Sprintf("I can speak %s: %s!", greeter.LanguageName(), greeter.hello(name))
}

type Italian struct{}

func (i Italian) LanguageName() string {
	return "Italian"
}

func (i Italian) hello(name string) string {
	return "Ciao " + name
}

func (i Italian) Greet(name string) string {
	return greet(name, i)
}

type Portuguese struct{}

func (p Portuguese) LanguageName() string {
	return "Portuguese"
}

func (p Portuguese) hello(name string) string {
	return "Olá " + name
}

func (p Portuguese) Greet(name string) string {
	return greet(name, p)
}
