#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

long n;
int m;
long long k;
bool wayToSort(int i, int j) { return i > j; }
void getNMK(std::string line)
{
    int currentNMK{ 1 };
    using namespace std;
    string nValue{};
    string mValue{};
    string kValue{};
    for (int i{ 0 }; i <= line.size(); i++)
    {
        if (line[i] != ' ')
        {
            switch (currentNMK)
            {
            case 1:
                nValue += line[i];
                break;
            case 2:
                mValue += line[i];
                break;
            case 3:
                kValue += line[i];
                break;
            }
        }
        else
        {
            ++currentNMK;
        }
    }
    n = stoi(nValue);
    m = stoi(mValue);
    k = stoi(kValue);
}

int main()
{
    // helped with love by FloweyTheFlower420

    std::ofstream fout("prize.out");
    std::ifstream fin("prize.in");
    std::string lineOne;
    getline(fin, lineOne);
    getNMK(lineOne);

    std::vector<int> candyValues;
    std::string currentLine;
    for (int i{ 0 }; i <= n-1; i++)
    {
        getline(fin, currentLine);
        candyValues.push_back(std::stoi(currentLine));
    }

    std::vector<long> sums(n + m - 1);
    int i, j;
    int sum = 0;
    for (j = 0; j < m; j++) {
        sum += candyValues[j];
    }
    sums[0] = sum;

    for (i = 1; i < candyValues.size() - m + 1; i++) 
    {
        sum -= candyValues[i - 1];
        sum += candyValues[i + m - 1];
        sums[i] = sum;
    }

    std::sort(sums.begin(), sums.end(), wayToSort);
    long prev = sums[0];
    size_t count = 0;
    for (auto &i : sums)
    {
        if (count == k)
	{
	    fout << i << std::endl;
            exit(0);
	}
        if (i != prev)
        {
            count++;
            prev = i;
        }
        else
        {
	    count++;
        }
    }
    return 0;
}
