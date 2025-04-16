#ifndef STACK_H
#define STACK_H

#include "list.h"

class Stack
{
public:
    Stack() = default;
    ~Stack() = default;
    void push(int value);
    int pop();
    bool isEmpty() const;
    std::vector<int> toVector() const;
private:
    List list;
};

#endif // STACK_H
