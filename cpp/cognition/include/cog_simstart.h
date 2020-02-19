#ifndef CogSimStart_SIMSTART_H
#define CogSimStart_SIMSTART_H

#include <string>
#include <vector>

#include <cog.h>

/**
 * Simulation start time Cog.
 */
class CogSimStart : public Cog {
  public:
    /**
     *  @return  true if successfully initialized
     */
    bool valid() const override;

    /**
     * @param  tokens  Text values to convert to a simulation start
     *                 time.
     */
    bool unserialize(const std::vector<std::string>& tokens) override;

  private:
    bool valid_state {false};
};

#endif
