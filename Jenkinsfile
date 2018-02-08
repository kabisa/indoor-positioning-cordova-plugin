projectId = "indoor-positioning-cordova-plugin"

pipeline {
  agent {
    dockerfile {
      filename "plugin/dockerfiles/ci/Dockerfile"
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
        sh "rm -rf plugin/node_modules | true"
        sh "bin/setup"
      }
    }

    stage("Tests") {
      steps {
        sh "cd plugin && bin/ci"
      }
    }
  }
}
