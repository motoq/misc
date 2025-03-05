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
  ~M14() override { std::cout << "\nM14 Destructor" << msg; }

  M14() = default;
  M14(std::string msg) { this->msg = ":  " + msg; }

  void fire() override { std::cout << "\nBang!"; }

private:
  std::string msg = "";
};

#endif  // M14_H

