import React from 'react';

export default function Statistiques () {
    return (
        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
            <div style={{ display: 'flex', flexDirection: 'column' , alignItems: 'center' }}>
                <h1 style={{ fontSize: 24, marginBottom: 20 }}>Statistiques</h1>
                <div style={{ width: 200, height: 50, marginBottom: 10, display: 'flex', justifyContent: 'center', alignItems: 'center', backgroundColor: 'lightgray' }}>
                    <a href="/publications" style={{ textDecoration: 'none', color: 'black' }}>Publications</a>
                </div>
                <div style={{ width: 200, height: 50, marginBottom: 10, display: 'flex', justifyContent: 'center', alignItems: 'center', backgroundColor: 'lightgray' }}>
                    <a href="/brevets" style={{ textDecoration: 'none', color: 'black' }}>Brevets</a>
                </div>
                <div style={{ width: 200, height: 50, marginBottom: 10, display: 'flex', justifyContent: 'center', alignItems: 'center', backgroundColor: 'lightgray' }}>
                    <a href="/financements" style={{ textDecoration: 'none', color: 'black' }}>Financements</a>
                </div>
                <div style={{ width: 200, height: 50, marginBottom: 10, display: 'flex', justifyContent: 'center', alignItems: 'center', backgroundColor: 'lightgray' }}>
                    <a href="/doctorats" style={{ textDecoration: 'none', color: 'black' }}>Doctorats</a>
                </div>
            </div>
        </div>
    );
}
