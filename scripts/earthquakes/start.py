from configuration import Configuration

import logging


def main():
    hdfs_path = ""
    list_of_years = []
    group_of_years = []
    minimum_magnitude = 0
    overwrite = False
    configuration = Configuration.Read()
    for config,value in configuration.items():
        if config =='save-to-hdfs-path':
           hdfs_path = value
        elif config =='list-of-years':
            list_of_years = value
        elif config == 'group-of-years':
            group_of_years = value
        elif config == 'minimum-magnitude':
            minimum_magnitude = value
        elif config == 'overwrite':
            overwrite = value
    print hdfs_path
    print list_of_years
    print group_of_years
    print minimum_magnitude
    print overwrite


if __name__ == "__main__":
    main()
