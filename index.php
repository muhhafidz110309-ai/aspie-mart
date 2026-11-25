<?php
require_once 'config/database.php';

if (!isLogin()) {
    redirect('login.php');
}

if (userRole() === 'admin') {
    redirect('admin/index.php');
} else {
    redirect('user/kasir.php');
}