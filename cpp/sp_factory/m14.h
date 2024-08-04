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
    M14() = default;
    explicit M14(std::string msg) { this->msg = ":  " + msg; }
    ~M14() override { std::cout << "\nM14 Destructor" << msg; }
    void fire() override { std::cout << "\nBang!"; }

    std::string getMsg() const { return msg; }

  private:
    std::string msg = "DefaultMsgM14";
};

std::ostream& operator<<(std::ostream& out, const M14& data) {
  return out << data.getMsg();
}

#endif

