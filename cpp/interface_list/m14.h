#ifndef M14_H
#define M14_H

#include <iostream>

#include <ishoot.h>

  // Note "public Shootable" to make base class accessible
class M14 : public IShoot {
  public:
    virtual ~M14() { std::cout << "\nM14 Destructor"; }
    virtual void fire() { std::cout << "\nBang!"; }
};

#endif  // M14_H

