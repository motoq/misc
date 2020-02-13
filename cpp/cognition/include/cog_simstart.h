#ifndef CogSimStart_SIMSTART_H
#define CogSimStart_SIMSTART_H

#include <string>
#include <vector>

#include <cog.h>

/**
 * Simulation start time
 */
class CogSimStart : public Cog {
  public:
    /** @return  true if successfully unserialized */
    bool valid() const override;

    bool unserialize(const std::vector<std::string>& tokens) override;

  private:
    bool valid_state {false};
};

#endif
