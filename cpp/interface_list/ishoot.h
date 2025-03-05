#ifndef ISHOOT_H
#define ISHOOT_H

/**
 * Interface for an object that shoots
 */
class IShoot {
public:
  virtual ~IShoot() = default;
  IShoot() = default;
  IShoot(const IShoot&) = delete;
  IShoot& operator=(const IShoot&) = delete;
  IShoot(IShoot&&) = delete;
  IShoot& operator=(IShoot&&) = delete;

  virtual void fire() = 0;
};

#endif

