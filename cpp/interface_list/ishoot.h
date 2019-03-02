#ifndef ISHOOT_H
#define ISHOOT_H

/**
 * Interface for an object that shoots
 */
class IShoot {
  public:
    virtual ~IShoot() {}
    virtual void fire() = 0;
};

#endif  // ISHOOT_H

