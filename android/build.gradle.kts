// allprojects {
//     repositories {
//         google()
//         mavenCentral()
//     }
// }

// rootProject.buildDir = "../build"
// subprojects {
//     project.buildDir = "${rootProject.buildDir}/${project.name}"
// }
// subprojects {
//     project.evaluationDependsOn(":app")
// }

// tasks.register("clean", Delete) {
//     delete rootProject.buildDir
// }


// DO NOT declare plugin versions here!
// Flutter manages Android plugin versions automatically.

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Optional: keep or remove this block (custom build directory)
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build")

subprojects {
    project.layout.buildDirectory.set(newBuildDir.map { it.dir(project.name) })
}

// Make sure NOT to include evaluationDependsOn
// It breaks AGP 8+ and Kotlin DSL

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
