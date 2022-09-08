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
    explicit M14E2(std::string msg) { this->msg = ":  " + msg; }
    ~M14E2() override { std::cout << "\nM14E2 Destructor" << msg; }
    void fire() override { std::cout << "\nBangBangBangBangBang!!!"; }

  private:
    std::string msg = "";
};

#endif

