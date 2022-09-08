#ifndef M14_H
#define M14_H

#include <iostream>
#include <string>

#include <ishoot.h>

/**
 * Semiautomatic
 */
class M14 : public IShoot {
  public:
    M14() {}
    explicit M14(std::string msg) { this->msg = ":  " + msg; }
    ~M14() override { std::cout << "\nM14 Destructor" << msg; }
    void fire() override { std::cout << "\nBang!"; }

  private:
    std::string msg = "";
};

#endif

