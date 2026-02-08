# Moonbit Code Generator

提供用于生成 MoonBit 源代码的 AST 定义和渲染器。

1. 定义 AST: 提供描述 MoonBit 语言结构的类型系统 (File, TopLevel, Stmt, Type, Expr)。
2. 渲染代码: 将 AST 转换为格式良好的 MoonBit 源代码字符串。
3. 格式化: 自动处理缩进、块注释 (///|)、可见性修饰符 (pub, priv) 和导入语句。

优先实现核心 AST，对于复杂的语句（如 match, loop），如果 AST 建模困难，允许通过 Stmt::Raw 和 Expr::Raw 提供逃生舱。
