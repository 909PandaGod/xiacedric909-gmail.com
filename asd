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
    std::ofstream fout("prize.out");
    std::ifstream fin("prize.in");
    std::string lineOne;
    getline(fin, lineOne);
    getNMK(lineOne);
    //std::cout << n << m << k;
    std::vector<int> candyValues;
    std::string currentLine;
    for (int i{ 0 }; i <= n-1; i++)
    {
        getline(fin, currentLine);
        candyValues.push_back(std::stoi(currentLine));
    }
    std::vector<long> sums;
    for (int j{ 0 }; j <= (n - m + 1); j++)
    {
        int currentSum = 0;
        for (int l{ 0 }; l <= (j + m - 1); l++)
        {
            currentSum += candyValues[j + l];
        }
        sums.push_back(currentSum);
    }
    std::sort(sums.begin(), sums.end(), wayToSort);
    fout << sums[k-1]<<std::endl;
    return 0;
}
