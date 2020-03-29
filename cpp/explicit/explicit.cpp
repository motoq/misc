#include <iostream>

#include <defaults.h>
#include <defaults_user.h>

void f(Defaults);
void g(DefaultsUser);

/**
 * This program illustrates the effect of explicit construction,
 * including how it now pertains to constructors that require multiple
 * arguments.  In the past, the decision to use explicit was limited to
 * constructors that would accept a single argument.  This is no longer
 * true with implicit list construction.
 *
 * @author  Kurt Motekew  2020/03/29
 */
int main()
{

  // Works without explicit
  //f(3);
  //f({3});
  //f({3, 2, 1});
  // Works with and without
  f(Defaults {3});
  f(Defaults {3, 2, 1});

  // Never works
  //g(3);
  // Works when Defaults is implicit (but not when DefaultsUser is
  // explicit) nor when Defaults is explicit
  //g({3});
  // Works when DefaultsUser is implicit, but not explicit
  //g(Defaults {3});
  g(DefaultsUser {Defaults {3}});

  std::cout << '\n';
  
}

void f(Defaults d)
{
  std::cout << '\n' << d.getx() << '\t' << d.gety() << '\t' << d.getz();
}

void g(DefaultsUser du)
{
  std::cout << '\n' << du.getx() << '\t' << du.gety() << '\t' << du.getz();
}
