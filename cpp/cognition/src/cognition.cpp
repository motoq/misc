#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <map>

#include <cog_simstart.h>   // KAM

static bool print_tokens(const std::vector<std::string>& c);

/**
 * Parses an input file and passes each line to the parser.
 */
int main(int argc, char* argv[])
{


/**
 * Keywords associated with inputs related to configuring a case file
 */
enum class CaseKeyWord {
  NONE,                           // Do nothing keyword
  COMPUTE,                        // Use definitions to compute something
  SIMSTART,                       // Simulation start time
  SIMDAYS                         // Simulation duration
};
/**
 * Table translating text keywords from input stream into enum values
 */

const std::map<std::string,CaseKeyWord> keyword_table {
  {"None",     CaseKeyWord::NONE},
  {"Compute",  CaseKeyWord::COMPUTE},
  {"SimStart", CaseKeyWord::SIMSTART},
  {"SimDays",  CaseKeyWord::SIMDAYS}
};


  // Check for filename
  if (argc != 2) {
    std::cerr << "\nProper use is:  " << argv[0] << " <input_file_name>\n";
    return 0;
  }
  // Try to open for input
  std::ifstream ifs(argv[1]);
  if (!ifs.is_open()) {
    std::cerr << "\nError opening " << argv[1] << "\n";
    return 0;
  }
  std::cout << "\nOpened " << argv[1];
  // Read each line and pass to parser while tracking line number
  int line_number {0};
  std::string input_line;
  bool parse_tokens = false;
  bool no_error = true;
  std::vector<std::string> tokens;
  const std::string endicator = "end";
  while (std::getline(ifs,input_line)) {
    line_number++;
    std::istringstream iss(input_line);
    std::string token;
    while (iss >> token  &&  no_error) {
      if (token[0] == '#') {
        break;
      } else {
        if (token == endicator) {
          parse_tokens = true;
        } else {
          tokens.push_back(token);
        }
        if (parse_tokens) {
          parse_tokens = false;
          no_error = print_tokens(tokens);
          tokens.clear();
        }
      }
    }
    if (!no_error) {
      std::cout << "\nError on line: " << line_number;
      break;
    }
  }
  ifs.close();

  std::cout << "\n\n";

}

static bool print_tokens(const std::vector<std::string>& c) {
  if (c.size() > 0) {
    std::string simst = "SimStart";
    if (c[0] ==  simst) {
      CogSimStart cog;
      cog.unserialize(c);
    } else {
      for(auto& s : c) {
	      std::cout << '\n' << s;
      }
    }
    return true;
  } else {
    return false;
  }
}
