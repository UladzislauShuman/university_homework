#ifndef COMPUTERITEM_H
#define COMPUTERITEM_H

#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
#include <QDate>

class EmployeeProjects
{
public:
    EmployeeProjects() = default;
    ~EmployeeProjects() = default;
    EmployeeProjects(
            const std::string& employeeName_,
            const std::string& projectName_,
            const std::string& task_,
            const std::string& dateOfCompletion_,
            const std::string& startDate_,
            const std::string& endDate_);

    std::string EmployeeName() const {return this->employeeName;}
    std::string ProjectName() const {return this->projectName;}
    std::string Task() const {return this->task;}
    std::string DateOfCompletion() const {return this->dateOfCompletion;}
    std::string StartDate() const {return this->startDate;}
    std::string EndDate() const {return this->endDate;}

    std::string to_string();
    std::string to_string1();

    friend bool DateEndCompare(const EmployeeProjects& a,const EmployeeProjects& b);
    //friend int DayOfWork(std::string dataA,std::string dataB);

private:
    std::string employeeName;
    std::string projectName;
    std::string task;
    std::string dateOfCompletion;
    std::string startDate;
    std::string endDate;
};

std::istream& operator>>(std::istream&, EmployeeProjects&);
std::ostream& operator<<(std::ostream&, EmployeeProjects&);
void ReadFile(std::vector<EmployeeProjects>&, const std::string);
int DayOfWork(std::string dataA,std::string dataB);

#endif // COMPUTERITEM_H
