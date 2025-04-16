/****************************************************************************
** Meta object code from reading C++ file 'playerdialog.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../playerdialog.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'playerdialog.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSPlayerDialogENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSPlayerDialogENDCLASS = QtMocHelpers::stringData(
    "PlayerDialog",
    "SignalPlayer",
    "",
    "Player",
    "std::string",
    "SignalPlayerWasChoosen",
    "on_okButton_clicked",
    "on_chooseProfileButton_clicked",
    "on_makeProfileButton_clicked",
    "on_createButton_clicked",
    "on_backButton_clicked",
    "takePlayerFromMainWindow",
    "Player*"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSPlayerDialogENDCLASS_t {
    uint offsetsAndSizes[26];
    char stringdata0[13];
    char stringdata1[13];
    char stringdata2[1];
    char stringdata3[7];
    char stringdata4[12];
    char stringdata5[23];
    char stringdata6[20];
    char stringdata7[31];
    char stringdata8[29];
    char stringdata9[24];
    char stringdata10[22];
    char stringdata11[25];
    char stringdata12[8];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSPlayerDialogENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSPlayerDialogENDCLASS_t qt_meta_stringdata_CLASSPlayerDialogENDCLASS = {
    {
        QT_MOC_LITERAL(0, 12),  // "PlayerDialog"
        QT_MOC_LITERAL(13, 12),  // "SignalPlayer"
        QT_MOC_LITERAL(26, 0),  // ""
        QT_MOC_LITERAL(27, 6),  // "Player"
        QT_MOC_LITERAL(34, 11),  // "std::string"
        QT_MOC_LITERAL(46, 22),  // "SignalPlayerWasChoosen"
        QT_MOC_LITERAL(69, 19),  // "on_okButton_clicked"
        QT_MOC_LITERAL(89, 30),  // "on_chooseProfileButton_clicked"
        QT_MOC_LITERAL(120, 28),  // "on_makeProfileButton_clicked"
        QT_MOC_LITERAL(149, 23),  // "on_createButton_clicked"
        QT_MOC_LITERAL(173, 21),  // "on_backButton_clicked"
        QT_MOC_LITERAL(195, 24),  // "takePlayerFromMainWindow"
        QT_MOC_LITERAL(220, 7)   // "Player*"
    },
    "PlayerDialog",
    "SignalPlayer",
    "",
    "Player",
    "std::string",
    "SignalPlayerWasChoosen",
    "on_okButton_clicked",
    "on_chooseProfileButton_clicked",
    "on_makeProfileButton_clicked",
    "on_createButton_clicked",
    "on_backButton_clicked",
    "takePlayerFromMainWindow",
    "Player*"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSPlayerDialogENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    2,   62,    2, 0x06,    1 /* Public */,
       5,    1,   67,    2, 0x06,    4 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       6,    0,   70,    2, 0x08,    6 /* Private */,
       7,    0,   71,    2, 0x08,    7 /* Private */,
       8,    0,   72,    2, 0x08,    8 /* Private */,
       9,    0,   73,    2, 0x08,    9 /* Private */,
      10,    0,   74,    2, 0x08,   10 /* Private */,
      11,    1,   75,    2, 0x0a,   11 /* Public */,

 // signals: parameters
    QMetaType::Void, 0x80000000 | 3, 0x80000000 | 4,    2,    2,
    QMetaType::Void, QMetaType::Bool,    2,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 12,    2,

       0        // eod
};

Q_CONSTINIT const QMetaObject PlayerDialog::staticMetaObject = { {
    QMetaObject::SuperData::link<QDialog::staticMetaObject>(),
    qt_meta_stringdata_CLASSPlayerDialogENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSPlayerDialogENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSPlayerDialogENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<PlayerDialog, std::true_type>,
        // method 'SignalPlayer'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<Player, std::false_type>,
        QtPrivate::TypeAndForceComplete<std::string, std::false_type>,
        // method 'SignalPlayerWasChoosen'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'on_okButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_chooseProfileButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_makeProfileButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_createButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_backButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'takePlayerFromMainWindow'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<Player *, std::false_type>
    >,
    nullptr
} };

void PlayerDialog::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<PlayerDialog *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->SignalPlayer((*reinterpret_cast< std::add_pointer_t<Player>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<std::string>>(_a[2]))); break;
        case 1: _t->SignalPlayerWasChoosen((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 2: _t->on_okButton_clicked(); break;
        case 3: _t->on_chooseProfileButton_clicked(); break;
        case 4: _t->on_makeProfileButton_clicked(); break;
        case 5: _t->on_createButton_clicked(); break;
        case 6: _t->on_backButton_clicked(); break;
        case 7: _t->takePlayerFromMainWindow((*reinterpret_cast< std::add_pointer_t<Player*>>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (PlayerDialog::*)(Player , std::string );
            if (_t _q_method = &PlayerDialog::SignalPlayer; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (PlayerDialog::*)(bool );
            if (_t _q_method = &PlayerDialog::SignalPlayerWasChoosen; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
    }
}

const QMetaObject *PlayerDialog::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *PlayerDialog::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSPlayerDialogENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QDialog::qt_metacast(_clname);
}

int PlayerDialog::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 8;
    }
    return _id;
}

// SIGNAL 0
void PlayerDialog::SignalPlayer(Player _t1, std::string _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void PlayerDialog::SignalPlayerWasChoosen(bool _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_WARNING_POP
