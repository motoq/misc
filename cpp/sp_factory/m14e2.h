#ifndef M14E2_H
#define M14E2_H

#include <iostream>

#include <ishoot.h>

/**
 * Full auto
 */
class M14E2 : public IShoot {
  public:
    M14E2() = default;
    explicit M14E2(std::string msg) { this->msg = ":  " + msg; }
    ~M14E2() override { std::cout << "\nM14E2 Destructor" << msg; }
    void fire() override { std::cout << "\nBangBangBangBangBang!!!"; }

    friend std::ostream& operator<<(std::ostream& out, const M14E2& data) {
      out << data.msg;
      return out;
    }


  private:
    std::string msg = "DefaultMsgM14E2";
};

#endif

