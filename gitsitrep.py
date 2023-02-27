import git # GitPython
import os
import sys

def main():
    for workdir in ["mothur-rs", "gitsitrep", "music-charts-tabs"]:
        dirpath = os.path.join("/Users/kelly/projects/personal/", workdir)
        repo = git.Repo(dirpath)
        print(f"{repo.working_tree_dir} {repo.is_dirty()} {repo.head.ref}")

if __name__ == "__main__":
    main()