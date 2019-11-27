#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <map>

static bool print_cogs(const std::vector<std::string>& c);

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
  bool parse_cogs = false;
  bool no_error = true;
  std::vector<std::string> cogs;
  const std::string endicator = "end";
  while (std::getline(ifs,input_line)) {
    line_number++;
    std::istringstream iss(input_line);
    std::string word;
    while (iss >> word  &&  no_error) {
      if (word[0] == '#') {
        break;
      } else {
        if (word == endicator) {
          parse_cogs = true;
        } else {
          cogs.push_back(word);
        }
        if (parse_cogs) {
          parse_cogs = false;
          no_error = print_cogs(cogs);
          cogs.clear();
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

  return 0;
}

static bool print_cogs(const std::vector<std::string>& c) {
  if (c.size() > 0) {
    for(auto& s : c) {
	    std::cout << '\n' << s;
    }
    return true;
  } else {
    return false;
  }
}
