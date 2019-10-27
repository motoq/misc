#ifndef M14E2_H
#define M14E2_H

#include <iostream>

#include <ishoot.h>

/**
 * Full auto
 */
class M14E2 : public IShoot {
  public:
    M14E2() {}
    M14E2(std::string msg) { this->msg = ":  " + msg; }
    virtual ~M14E2() { std::cout << "\nM14E2 Destructor" << msg; }
    virtual void fire() { std::cout << "\nBangBangBangBangBang!!!"; }

  private:
    std::string msg = "";
};

#endif  // M14E2_H

