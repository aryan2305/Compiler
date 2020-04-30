#include <bits/stdc++.h>

using namespace std;

enum Type
{
    _integer,
    _float,
    _void,
    _function,
    _none
};

class AstNode
{
protected:
    string label; // lexeme/token/node name
    string value; // lexeme/token/node value
    vector<AstNode *> child;

public:
    int numChild;

    AstNode(string lb, string val)
    {
        label = lb;
        value = val;
        numChild = 0;
    }

    void addChild(AstNode *cd)
    {
        child.push_back(cd);
        numChild = child.size();
    }

    AstNode *getChild(int i)
    {
        assert(i < numChild);
        return child[i];
    }
};

class Variable : public AstNode
{
private:
    Type dataType;

public:
    Type getDataType()
    {
        return dataType;
    }

    void setDataType(Type tp)
    {
        dataType = tp;
    }
};

class Arglist
{
public:
    vector<pair<Type, string>> arguments;

    Arglist()
    {
    }

    bool isEmpty()
    {
        if (arguments.size() == 0)
            return true;

        return false;
    }
    void addArgument(Type tp, string name)
    {
        arguments.push_back({tp, name});
    }

    pair<Type, string> getArgument(int i)
    {
        assert(i < arguments.size());
        return arguments[i];
    }
};

class Function : public AstNode
{
private:
    Type returnType;

public:
    Arglist *arglist;

    Type getDataType()
    {
        return returnType;
    }

    void setDataType(Type tp)
    {
        returnType = tp;
    }
};
