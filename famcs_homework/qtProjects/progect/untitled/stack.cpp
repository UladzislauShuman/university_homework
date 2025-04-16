#include "stack.h"

void Stack::push(int value) {
    this->list.prepend(value);
}

int Stack::pop() {
    int result = this->list.removeFirst();
    return result;
}

bool Stack::isEmpty() const {
    return this->list.isEmpty();
}

std::vector<int> Stack::toVector() const {
    return list.toVector();
}
