#ifndef LIST_H
#define LIST_H

#include <vector>

class List
{
public:
    List();
    List(int value);
    List(int value1, int value2, int value3);
    ~List();
    struct SElement {
        int data;
        SElement* next;
        SElement() = default;
        SElement(int data_, SElement* next_) : data(data_), next(next_) {}
        ~SElement() = default;
    };
    void print();
    bool isEmpty() const;
    void prepend(int value);
    int removeFirst();
    std::vector<int> toVector() const;
private:
    SElement* head;
};

#endif // LIST_H
