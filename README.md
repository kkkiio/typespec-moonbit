# kkkiio/typespec-moonbit

Typespec MoonBit Emitter. Writen in MoonBit.

## Features

- [x] http server

## Architecture

#### Adapter 流程图 (`tcgcadapter`)

展示如何将 TypeSpec 编译器对象转换为 `CodeModel`。

```mermaid
flowchart TD
    Start([Start: Adapter::tcgc_to_crate]) --> CallJS[Call TypeSpec HTTP API]
    CallJS --> GroupOps[Group Ops by Client]
    
    subgraph Client_Process [Client & Method Building]
        GroupOps --> OpLoop{Iterate Ops}
        OpLoop --> BuildMethod[Build Method Metadata]
        BuildMethod --> ResolveType{"Resolve Type\n(Recursive)"}
        ResolveType --> AddMethod[Add to Client]
        AddMethod --> OpLoop
    end
    
    OpLoop -- Done --> BuildCrate[Assemble codemodel.Crate]
    BuildCrate --> Return([Return Crate])
```

#### Server Codegen 流程图 (`server.mbt`)

展示如何根据 `CodeModel` 生成服务端的 MoonBit 源代码。

```mermaid
flowchart TD
    Start([Start: emit_server_files]) --> Step1[1. Collect Unique Models]
    
    subgraph Content_Gen [router.mbt Generation]
        Step1 --> Step2[2. Generate Model Structs]
        Step2 --> Step3[3. Generate Handler Traits]
        Step3 --> Step4[4. Generate Router Function\nMatching & Dispatch]
        Step4 --> Step5[5. Append Utils\nPath/Query/Header helpers]
    end
    
    Content_Gen --> BuildFiles[Assemble Output Files\npkg.json, README, router.mbt]
    BuildFiles --> Return([Return Output Files])
```
