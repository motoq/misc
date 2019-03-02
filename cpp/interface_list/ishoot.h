#ifndef ISHOOT_H
#define ISHOOT_H

class IShoot {
  public:
    virtual ~IShoot() {}
    virtual void fire() = 0;
};

#endif  // ISHOOT_H

