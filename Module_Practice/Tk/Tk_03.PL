#!/usr/bin/perl -w
use Tk;
use Encrypt;
 
my $encrypt = -1;
my $userinput = "";
my $result = "";
         
my $mw = MainWindow->new;
$mw->title("Encryptor");
 
my $input_label = $mw->Label(-text => "Input:");
$input_label->grid(-row => 0, -column => 0);        
my $input_field = $mw->Entry();
$input_field->grid(-row => 0, -column => 1, -columnspan => 6, -sticky => "ew");
my $output_label = $mw->Label(-text => "Output:");
$output_label->grid(-row => 1, -column => 0);        
my $output_field = $mw->Entry();
$output_field->grid(-row => 1, -column => 1, -columnspan => 6, -sticky => "ew");
 
my $new_button = $mw->Button(-text => "New", -command => \&new_button);
$new_button->grid(-row => 2, -column => 0);
my $load_button = $mw->Button(-text => "Load", -command => \&load_button);
$load_button->grid(-row => 2, -column => 1);
my $save_button = $mw->Button(-text => "Save", -command => \&save_button);
$save_button->grid(-row => 2, -column => 2);
my $encode_button = $mw->Button(-text => "Encode", -command => \&encode_button);
$encode_button->grid(-row => 2, -column => 3);
my $decode_button = $mw->Button(-text => "Decode", -command => \&decode_button);
$decode_button->grid(-row => 2, -column => 4);
my $clear_button = $mw->Button(-text => "Clear", -command => \&clear_button);
$clear_button->grid(-row => 2, -column => 5);
my $copy_button = $mw->Button(-text => "Copy", -command => \&copy_button);
$copy_button->grid(-row => 2, -column => 6);
 
my $display_message = "something happened";
my $display_label = $mw->Label(-text => $display_message, -textvariable => \$display_message);
$display_label->grid(-row => 3, -column => 0, -columnspan => 7); 
 
sub new_button {
    $encrypt = new Encrypt;
    $display_message = "code: ".$encrypt->getCode();
}
 
sub load_button {
    my $data;
    if (-e './code.txt') {
        open(DATA, "<code.txt");
        read DATA, $data, 26;
        $encrypt = new Encrypt;
        $encrypt->setCode($data);
        close(DATA);
        $display_message = "code: ".$encrypt->getCode();
    }
    else {
        $display_message = "Load denied!!";
    } 
}
 
sub save_button {
    if ($encrypt == -1) {
        $display_message = "No Encrypt object can save!!";
    }
    else {
        open(CODE, ">code.txt");
        print CODE $encrypt->getCode();
        close(CODE);
        $display_message = "The code is saved.";
    }
}
 
sub encode_button {
    $userinput = $input_field->get();
    if ($userinput eq "") {
        $display_message = "No input string!!";
    }
    else {
        if ($encrypt == -1) {
            $display_message = "No encrypt object!!";
        }
        else {
            $result = $encrypt->toEncode($userinput);
            $output_field->delete('0', 'end');
            $output_field->insert('end', $result);
            $display_message = "Encoding success!!";
        }
    }    
}
 
sub decode_button {
    $userinput = $input_field->get();
    if ($userinput eq "") {
        $display_message = "No input string!!";
    }
    else {
        if ($encrypt == -1) {
            $display_message = "No encrypt object!!";
        }
        else {
            $result = $encrypt->toDecode($userinput);
            $output_field->delete('0', 'end');
            $output_field->insert('end', $result);
            $display_message = "Decoding success!!";
        }
    }    
}
 
sub clear_button {
    $encrypt = -1;
    $userinput = "";
    $result = "";
    $input_field->delete('0', 'end');
    $output_field->delete('0', 'end');
    $display_message = "It's done.";
}
 
sub copy_button {
    if ($result eq "") {
        $display_message = "Copy denied!!";
    }
    else {
        $mw->clipboardClear;
        $mw->clipboardAppend($result);
        $display_message = "It is already copied to the clipboard.";
    }
}  
       
MainLoop;