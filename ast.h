#include <bits/stdc++.h>

using namespace std;

enum Type
{
    _integer,
    _float,
    _void,
    _none
};

enum NodeType
{
    _astnode,
    _varnode,
    _funcnode
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

    void concatArglist(Arglist *lst)
    {
        arguments.insert(arguments.end(), (lst->arguments).begin(), (lst->arguments).end());
    }
};

class AstNode
{
protected:
    string label; // lexeme/token/node name
    string value; // lexeme/token/node value
    NodeType nodetype;

    Type dataType;

public:
    vector<AstNode *> child;
    int numChild;

    Arglist *arglist;

    AstNode(string lb, string val, NodeType nt)
    {
        label = lb;
        value = val;
        nodetype = nt;
        numChild = 0;
    }

    void setlabel(string s)
    {
        label = s;
    }

    string getlabel()
    {
        return label;
    }

    void setValue(string s)
    {
        value = s;
    }

    string getValue()
    {
        return value;
    }

    NodeType getNodeType()
    {
        return nodetype;
    }

    void setNodeType(NodeType nt)
    {
        nodetype = nt;
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

    Type getDataType()
    {
        return dataType;
    }

    void setDataType(Type tp)
    {
        dataType = tp;
    }
};
