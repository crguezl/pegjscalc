/*
 * Classic example grammar, which recognizes simple arithmetic expressions like
 * "2*(3+4)". The parser generated from this grammar then AST.
 */

{
  var tree = function(f, r) {
    if (r.length > 0) {
      var last = r.pop();
      var result = {
        type:  last[0],
        left: tree(f, r),
        right: last[1]
      };
    }
    else {
      var result = f;
    }
    return result;
  }
}

st     = CL s1:st r:(SC st)* CR {
               console.log(s1);
               console.log(r);
               return {
                 type: 'COMPOUND',
                 children: [s1].concat(r.map( ([_, st]) => st ))
               };
            }
       / IF e:assign THEN st:st ELSE sf:st
           {
             return {
               type: 'IFELSE',
               c:  e,
               st: st,
               sf: sf,
             };
           }
       / IF e:assign THEN st:st    
           {
             return {
               type: 'IF',
               c:  e,
               st: st
             };
           }
       / i:ID ASSIGN e:cond            
            { return {type: '=', left: i, right: e}; }
       / cond

assign = i:ID ASSIGN e:cond            
            { return {type: '=', left: i, right: e}; }
       / cond

cond = l:exp op:COMP r:exp { return { type: op, left: l, right: r} }
     / exp

exp    = t:term   r:(ADD term)*   { return tree(t,r); }
term   = f:factor r:(MUL factor)* { return tree(f,r); }

factor = NUMBER
       / ID
       / LEFTPAR t:assign RIGHTPAR   { return t; }

_ = $[ \t\n\r]*

ASSIGN   = _ op:'=' _  { return op; }
ADD      = _ op:[+-] _ { return op; }
MUL      = _ op:[*/] _ { return op; }
LEFTPAR  = _"("_
RIGHTPAR = _")"_
CL       = _"{"_
CR       = _"}"_
SC       = _";"_
IF       = _ "if" _
THEN     = _ "then" _
ELSE     = _ "else" _
ID       = _ id:$([a-zA-Z_][a-zA-Z_0-9]*) _ 
            { 
              return { type: 'ID', value: id }; 
            }
NUMBER   = _ digits:$[0-9]+ _ 
            { 
              return { type: 'NUM', value: parseInt(digits, 10) }; 
            }
COMP     = _ op:("=="/"!="/"<="/">="/"<"/">") _ { 
               return op;
            }
