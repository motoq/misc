#include <iostream>
#include <utility>
#include <memory>

#include <ishoot.h>
#include <m14.h>
#include <m14e2.h>

static void operate(IShoot&);

enum class ModelM14 { m14, m14e2 };

/**
 * Variadic template factory function that perfect forwards parameters
 * 
 * @param  model   ID distinguishing which object to return
 * @param  params  Argument list needed for specified object
 *
 * @return  unique_ptr to the created object
 */
template<typename... Ts>
auto makeBangBang(ModelM14 model, Ts&&... params)
{
  std::unique_ptr<IShoot>pBang(nullptr);
  if (model == ModelM14::m14e2) {
    pBang.reset(new M14E2(std::forward<Ts>(params)...));
  } else {
    pBang.reset(new M14(std::forward<Ts>(params)...));
  }
  return pBang;
}
  
/**
 * Demonstrates use of a variadic template factory function.  This type
 * of factory allows for a variable number of parameters to be supplied
 * without any runtime cost since the list is evaluated at compile time.
 *
 * The use of passing a derived class to a function expecting a
 * reference to a base class is also demonstrated.
 */
int main()
{

    // Note when destruction of each occurs
  std::cout << "\nmakeBangBang M14 single use pointer";
  auto a = makeBangBang(ModelM14::m14, "Pointer not reused");
  a->fire();
    // Reuse pointer
  std::cout << "\nmakeBangBang M14 first use of pointer";
  auto b = makeBangBang(ModelM14::m14, "First use of pointer");
  b->fire();
  std::cout << "\nmakeBangBang M14E2 second use of pointer";
  b = makeBangBang(ModelM14::m14e2, "Second use of pointer");
  b->fire();

    // Pass to function expecting reference to the base class
  std::cout << "\nLocal M14 and M14E2 operated as base class via reference";
  M14 m14;
  operate(m14);
  M14E2 m14e2;
  operate(m14e2);

  std:: cout << "\n\nTest m14 ostream print:   " << m14;
  std:: cout << "\nTest m14e2ostream print:  " << m14e2;

  std::cout << '\n';
}

/** @param  Operates the fire() function of the passed in object */
static void operate(IShoot& g)
{
  g.fire();
}
