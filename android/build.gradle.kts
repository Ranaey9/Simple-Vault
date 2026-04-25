allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.layout.buildDirectory.set(rootProject.layout.buildDirectory.dir("../../build"))

subprojects {
    project.layout.buildDirectory.set(rootProject.layout.buildDirectory.dir("../../build").get().dir(project.name))
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}