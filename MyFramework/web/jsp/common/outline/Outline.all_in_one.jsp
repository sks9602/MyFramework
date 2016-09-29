<%@ page language="java" contentType="text/html;  charset=utf-8" pageEncoding="utf-8"%>
Ext.form.VTypes['alphanewMask'] = /[A-Za-z]/;
Ext.form.VTypes['alphanewText'] = 'Invalid Entry: Only alphabets are allowed.';
Ext.form.VTypes['alphanew'] = function(val) {
     return Ext.form.VTypes['alphanewVal'].test(val);
};

Ext.form.VTypes['numericposVal'] =   /^[\d]+$/;
Ext.form.VTypes['numericposMask'] = /[\d]/;
Ext.form.VTypes['numericposText'] = 'Invalid Entry: Must be in the format Ex. 1';
Ext.form.VTypes['numericpos'] = function(val){
    return Ext.form.VTypes['numericposVal'].test(val);
};