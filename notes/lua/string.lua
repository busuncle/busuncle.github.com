s = "hello world"
i, j = string.find(s, "hello")
print(i, j) --> 1   5
print(string.sub(s, i, j))  --> hello
i, j = string.find(s, "zzz")
print(i, j) --> nil    nil

date = "today is 17/7/1990"
print(string.match(date, "%d+/%d+/%d+"))    --> 17/7/1990

str = string.gsub("let's go go go", "go", "die")    --> let's die die die

words = {}
for w in string.gmatch("go to die", "%a+") do
    words[#words + 1] = w
end
print(table.concat(words, ",")) --> go,to,die

print(string.gsub("one, and two; and three", "%a+", "word"))    --> word, word word; word word

print(string.gsub("int x; /* x */ int y; /* y */", "/%*.*%*/", "")) --> int x;
print(string.gsub("int x; /* x */ int y; /* y */", "/%*.-%*/", "")) --> int x; int y;

k, v = string.match("name = Anna", "(%a+)%s*=%s*(%a+)")
print(k, v) --> name Anna

print(string.gsub("\\cmd{some text}", "\\(%a+){(.-)}", "<%1>%2</%1>"))  --> <cmd>some text</cmd>

print((string.gsub("   abc def   ", "^%s*(.-)%s*$", "%1")))   --> abc def

print((string.gsub("$a is $b", "$(%w+)", {a='x', b='y'})))  --> x is y
