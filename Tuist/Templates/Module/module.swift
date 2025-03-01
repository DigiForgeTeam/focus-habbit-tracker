import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Template for creating a new module",
    attributes: [
        nameAttribute
    ],
    items: [
        .file(
            path: "Modules/{{ name }}/Sources/{{ name }}ViewController.swift",
            templatePath: "ViewController.stencil"
        ),
        .file(
            path: "Modules/{{ name }}/Sources/{{ name }}Presenter.swift",
            templatePath: "Presenter.stencil"
        ),
        .file(
            path: "Modules/{{ name }}/Sources/{{ name }}Model.swift",
            templatePath: "Model.stencil"
        ),
        .file(
            path: "Modules/{{ name }}/Sources/{{ name }}Coordinator.swift",
            templatePath: "Coordinator.stencil"
        )
    ]
)
