#ifndef MYLIST_H
#define MYLIST_H
#include <iostream>

template<class T>
class MyList
{
public:

    struct SElement
    {
        T data;
        SElement* next;
        SElement() = default;
        SElement(const T& data_, SElement* next_ = nullptr) :
            data{ data_ }, next{ next_ } {}
        ~SElement() = default;
    };
    MyList();
    MyList(const std::initializer_list<T>&);
    void push_back(const T&);
    T pop_back();
    int getSize() { return size; }
    T pop_front();
    void print();
    void rshow();
    void push_front(const T&);
    void insert(const T&, size_t);
    void remove(const T&);
    ~MyList();

    class Iterator
    {
    public:
        Iterator() = default;
        Iterator(SElement* ptr_) :ptr(ptr_) {};
        Iterator operator++()
        {
            ptr = ptr->next;
            return *this;
        }
        Iterator operator++(int)
        {
            Iterator temp(*this);
            this->operator++();
            return temp;
        }
        T& operator*() { return  (*ptr).data; }
        const T& operator*()const { return  (*ptr).data; }
        bool operator!=(const Iterator& it) const
        {
            return ptr != it.ptr;
        }
        bool operator==(const Iterator& it) const
        {
            return ptr == it.ptr;
        }
        ~Iterator() = default;
    private:
        SElement* ptr;
    };
    Iterator Begin() { return this->head; }
    Iterator End() { return this->tail->next; }


//     class rIterator
//     {
//     public:
//         rIterator() = default;
//         rIterator(SElement* ptr_) :ptr(ptr_) {};

//         rIterator operator++()
//         {
//             ptr = ptr->prev;
//             return *this;
//         }

//         rIterator operator++(int)
//         {
//             rIterator temp(*this);
//             this->operator++();
//             return temp;
//         }
//         T& operator*() { return  (*ptr).data; }
//         const T& operator*()const { return  (*ptr).data; }
//         bool operator!=(const rIterator& it) const
//         {
//             return ptr != it.ptr;
//         }
//         bool operator==(const rIterator& it) const
//         {
//             return ptr == it.ptr;
//         }
//         ~rIterator() = default;
//     private:
//         SElement* ptr;
//     };
//     rIterator rBegin() { return this->tail; }
//     rIterator rEnd() { return this->head->prev; }
private:
    size_t size;
    SElement* head;
    SElement* tail;

};

#endif // MYLIST_H
