#include "functions.h"

bool checkDate(const std::string& date)
{
    int day,month,year;
    char dot;
    std::istringstream inDate(date);
    inDate >> day >> dot >> month >> dot >> year;
        //    до нашей эры?
    if(day <= 0 or month <= 0 or year < 0)
        return false;
    int monthD;
    enum { jan = 1, feb, march, apr, may, jun, jul, aug, sep, oct, nov, dec };

    switch (month) {
    case jan: case march: case may:
    case jul: case aug: case oct: case dec:
        monthD = 31; break;
    case apr: case jun: case sep: case nov:
        monthD = 30; break;
    case feb:
        ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) ? monthD = 29 : monthD = 28;
        break;
    default: return false; break;
    }
    if(day <= 0 or day > monthD)
        return false;

    return true;
}

bool DateCompare(const std::string& dateA,const std::string& dateB)
{
    int dayA,monthA,yearA,
        dayB,monthB,yearB;
    char dot;
    std::istringstream inA(dateA);
    inA >> dayA >> dot >> monthA >> dot >> yearA;

    std::istringstream inB(dateB);
    inB >> dayB >> dot >> monthB >> dot >> yearB;

    bool ans = true;
    if(yearB > yearA)
        return ans;
    else {
        if(yearB == yearA){
            if(monthB > monthA)
                return ans;
            else {
                if(monthB == monthA){
                    if(dayB > dayA)
                        return ans;
                    else
                        return !ans;
                }
                else
                    return !ans;
            }
        }
        else
            return !ans;
    }
    return true;
}
