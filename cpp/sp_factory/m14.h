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
    virtual ~M14() { std::cout << "\nM14 Destructor" << msg; }
    virtual void fire() { std::cout << "\nBang!"; }

  private:
    std::string msg = "";
};

#endif  // M14_H

