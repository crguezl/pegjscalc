
const eachBlockPre = (t, action, args) => {
  action(t, args);
  t.functions.forEach( (fun) => eachBlockPre(fun, action, args));
};

function semantic(tree) {
  eachBlockPre(tree, (t, args) => console.log(t.name.value), null)
}

module.exports = semantic;
