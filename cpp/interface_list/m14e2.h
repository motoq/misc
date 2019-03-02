#ifndef M14E2_H
#define M14E2_H

#include <iostream>

#include <ishoot.h>

class M14E2 : public IShoot {
  public:
    virtual ~M14E2() { std::cout << "\nM14E2 Destructor"; }
    virtual void fire() { std::cout << "\nBangBangBangBangBang!!!"; }
};

#endif  // M14E2_H

