#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

vector<vector<int>> input = { {4, 1, 4, 2, 3}
                            , {5, 1, 4, 2, -1, 6}
                            , {4, 19, 22, 24, 21}
                            , {4, 19, 22, 24, 25}
                            , {4, 2, -1, 0, 2}
                            };

void printVec(const vector<int> vec) {
  for(auto const& v: vec) {
    cout << v << " ";
  }
}

bool isJumper(const vector<int> row) {
  if(row.size() == 1) return true;

  vector<int> diffs = vector<int>();

  auto it = row.begin();
  ++it; // skip the first number
  int prev = *it;
  ++it;
  for(; it != row.end(); ++it) {
    diffs.push_back(abs(*it - prev));
    prev = *it;
  }

  sort(diffs.begin(), diffs.end());

  int diff = 1;
  for(auto const& d: diffs) {
    if(d != diff) return false;

    diff += 1;
  }

  return true;
}

int main(int argc, char const *argv[]) {
  for(auto const& row: input) {
    printVec(row);
    if(isJumper(row)) cout << "JOLLY" << endl;
    else cout << "NOT JOLLY" << endl;
  }
  return 0;
}
