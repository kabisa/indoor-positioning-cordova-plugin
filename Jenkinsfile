projectId = "indoor-positioning-cordova-plugin"

pipeline {
  agent {
    dockerfile {
      filename "dockerfiles/ci/Dockerfile"
      additionalBuildArgs support.ciDockerFileBuildArgs()
      args support.ciDockerFileRunArgs(projectId)
    }
  }

  options {
    ansiColor("xterm")
  }

  stages {
    stage("Setup") {
      steps {
        sh "rm -rf node_modules | true"
        sh "bin/setup"
      }
    }

    stage("Tests") {
      steps {
        sh "bin/ci"
      }
    }
  }
}
