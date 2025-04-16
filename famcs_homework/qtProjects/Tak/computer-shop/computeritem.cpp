#include "computeritem.h"

#include <math.h>
#include <sstream>

EmployeeProjects::EmployeeProjects(
            const std::string& employeeName_,
            const std::string& projectName_,
            const std::string& task_,
            const std::string& dateOfCompletion_,
            const std::string& startDate_,
            const std::string& endDate_):
    employeeName(employeeName_),
    projectName(projectName_),
    task(task_),
    dateOfCompletion(dateOfCompletion_),
    startDate(startDate_),
    endDate(endDate_) {}

std::istream& operator>>(std::istream& in, EmployeeProjects& item) {
    std::string employeeName;
    std::string projectName;
    std::string task;
    std::string dateOfCompletion;
    std::string startDate;
    std::string endDate;
    in >> employeeName >> projectName >> task >> dateOfCompletion >> startDate >> endDate;

    item = EmployeeProjects(employeeName, projectName, task, dateOfCompletion, startDate, endDate);

    return in;
}
std::ostream& operator<<(std::ostream&,EmployeeProjects&);

void ReadFile(std::vector<EmployeeProjects>& employeeProjects, const std::string fileName)
{
    std::ifstream fin(fileName);
    EmployeeProjects item;
    while(fin >> item)
    {
        employeeProjects.push_back(item);
    }
}

std::string EmployeeProjects::to_string()
{
    return employeeName + " " + projectName + " " + task + " " + dateOfCompletion + " " + startDate + " " + endDate + "\n";
}

std::string EmployeeProjects::to_string1()
{
    return employeeName + " " + projectName + " " + task + " ";
}

bool DateEndCompare(const EmployeeProjects& a,const EmployeeProjects& b)
{
    std::string dateA = a.EndDate();
    std::string dateB = b.EndDate();

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

int DayOfWork(std::string dateA, std::string dateB)
{
    //std::string dateA = a.StartDate();
    //std::string dateB = b.EndDate();

    int dayA,monthA,yearA,
        dayB,monthB,yearB;
    char dot;
    std::istringstream inA(dateA);
    inA >> dayA >> dot >> monthA >> dot >> yearA;

    std::istringstream inB(dateB);
    inB >> dayB >> dot >> monthB >> dot >> yearB;

    int days = abs((dayB + monthB * 30 + yearB * 365) - (dayA + monthA * 30 + yearA * 365));
    return days;
}
