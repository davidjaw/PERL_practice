use v5.18.2;
use person;
use dog;

sub main()
{
    my $object = {"name" => "tom"};

    # 先把"tom"变为人
    bless($object, "person");
    $object->sleep();
    $object->study();

    # 再把"tom"变为狗
    bless($object, "dog");
    $object->sleep();
    $object->bark();

    # 最后，再把"tom"变回人
    bless($object, "person");
    $object->sleep();
    $object->study();
}

&main();

# 程序运行时输出：
# tom is person, he is sleeping
# tom is person, he is studying
# tom is dog, he is sleeping
# tom is dog, he is barking
# tom is person, he is sleeping
# tom is person, he is studying