# Typespec Reader

封装与 TypeSpec Compiler 的 JS FFI 交互，提供高层次、类型安全的查询 API。

Zero-Copy 倾向: 尽量持有 JsValue 引用并在调用方法时实时查询 JS 属性，而不是在初始化时将所有数据复制到 MoonBit 结构体中（减少中间层适配与全量转换开销）。

Lazy Evaluation: 仅在需要时解析复杂的递归类型。
