import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Template for creating a new module",
    attributes: [
        nameAttribute
    ],
    items: [
        .file(
            path: "Modules/{{ name }}/Sources/UseCases/{{ name }}UseCase.swift",
            templatePath: "UseCase.stencil"
        ),
        .file(
            path: "Modules/{{ name }}/Sources/Presenter/{{ name }}Presenter.swift",
            templatePath: "Presenter.stencil"
        ),
        .file(
            path: "Modules/{{ name }}/Sources/Services/{{ name }}Service.swift",
            templatePath: "Service.stencil"
        ),
        .file(
            path: "Modules/{{ name }}/Sources/Models/{{ name }}Model.swift",
            templatePath: "Model.stencil"
        ),

        .file(
            path: "Modules/{{ name }}/Tests/{{ name }}UseCaseTests.swift",
            templatePath: "UseCaseTests.stencil"
        ),
        .file(
            path: "Modules/{{ name }}/Tests/{{ name }}ServiceTests.swift",
            templatePath: "ServiceTests.stencil"
        ),

        .file(
            path: "Modules/{{ name }}/Project.swift",
            templatePath: "Project.stencil"
        ),
//        .file(
//            path: "Modules/{{ name }}/Tuist/Config.swift",
//            templatePath: "Config.stencil"
//        )
    ]
)
